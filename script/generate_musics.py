import argparse
import random
from audiocraft.models import MusicGen, MultiBandDiffusion
import torchaudio

def generate_music(input_melody, output_path, number, style):
    # Load the input melody file
    melody, _ = torchaudio.load(input_melody)

    # Initialize the music generation model
    music_gen = MusicGen()
    mb_diffusion = MultiBandDiffusion()

    # Process the melody (this step may vary based on your specific model's requirements)
    processed_melody = mb_diffusion.process(melody)

    # Generate music based on the style and processed melody
    generated_music = music_gen.generate(processed_melody, style)

    # Save the generated music to the specified output path
    torchaudio.save(output_path, generated_music, 44100)  # Assuming 44100 Hz sample rate


def main():
    parser = argparse.ArgumentParser(description='Music Generation Script')
    parser.add_argument('--input_melody', type=str, required=True, help='Path to input melody file')
    parser.add_argument('--output_dir', type=str, required=True, help='Directory to save generated music')
    parser.add_argument('--num_generations', type=int, default=100, help='Number of music pieces to generate')
    parser.add_argument('--style', type=str, required=True, help='Style description for the music generation')

    args = parser.parse_args()

    for i in range(1, args.num_generations + 1):
        generate_music(args.input_melody, f"{args.output_dir}/{i}.mp3", i, args.style)

if __name__ == "__main__":
    main()
